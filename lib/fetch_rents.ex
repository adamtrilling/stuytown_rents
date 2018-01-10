defmodule StuytownRents.RentLoader do
    import Ecto.Query
    use Private

    def fetch() do
        HTTPoison.start
        url = "https://www.stuytown.com/no-fee-apartments-nyc"

        {:ok, %HTTPoison.Response{status_code: 200, body: body}} = HTTPoison.get(url)
    
        StuytownRents.Repo.insert(%StuytownRents.HtmlSnapshot{
            html: body,
            availability_date: Date.utc_today()
        })
    end

    def load() do
        query = from s in StuytownRents.HtmlSnapshot, 
            where: s.processed == false
        Enum.each(query |> StuytownRents.Repo.all, fn(snapshot) ->
            process_snapshot(snapshot)
        end)
    end

    def fetch_and_load() do
        fetch()
        load()
    end

    private do
        def process_snapshot(snapshot) do
            units = Enum.map(Floki.find(snapshot.html, "div.unit-card"), fn(unit) -> 
                {_, attrs, _} = unit
                Enum.reduce(attrs, %{}, fn({key, val}, acc) -> Map.put(acc, key, val) end)
            end)
            
            Enum.each(units, fn(unit) ->
              %{"data-price" => price, 
                "data-building" => building,
                "data-unit" => floor,
                "data-line" => line,
                "data-sqft" => size,
                "data-beds" => bedrooms
              } = unit
            
              building = StuytownRents.Building.find_or_create(building)
              unit = StuytownRents.Unit.find_or_create(building, floor, line, size, bedrooms)
            
              StuytownRents.Repo.insert(%StuytownRents.Listing{
                unit: unit, price: elem(Integer.parse(price), 0)
              })
            end)

            StuytownRents.Repo.update(Ecto.Changeset.change(
                snapshot, processed: true
            ))
        end
    end
end