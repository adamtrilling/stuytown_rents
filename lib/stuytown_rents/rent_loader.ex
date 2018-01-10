defmodule StuytownRents.RentLoader do
    import Ecto.Query
    use Private

    def fetch() do
        HTTPoison.start
        url = "https://www.stuytown.com/no-fee-apartments-nyc"

        {:ok, %HTTPoison.Response{status_code: 200, body: body}} = HTTPoison.get(url)
    
        StuytownRents.Repo.insert(%StuytownRents.Models.HtmlSnapshot{
            html: body,
            availability_date: Date.utc_today()
        })
    end

    def load() do
        query = from s in StuytownRents.Models.HtmlSnapshot, 
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
            
              building = StuytownRents.Models.Building.find_or_create(building)
              unit = StuytownRents.Models.Unit.find_or_create(building, floor, line, size, bedrooms)
            
              StuytownRents.Repo.insert(%StuytownRents.Models.Listing{
                unit: unit, price: elem(Integer.parse(price), 0)
              })
            end)

            StuytownRents.Repo.update(Ecto.Changeset.change(
                snapshot, processed: true
            ))
        end
    end
end