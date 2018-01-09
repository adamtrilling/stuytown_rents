defmodule StuytownRents.Unit do
    use Ecto.Schema
    use Private

    schema "units" do
        belongs_to :building, StuytownRents.Building
        field :floor, :string
        field :line, :string
        field :size, :integer
        field :bedrooms, :float
    end

    def find_or_create(building, floor, line, size, bedrooms) do
        case StuytownRents.Repo.get_by(StuytownRents.Unit, 
            building_id: building.id, floor: floor, line: line) do
            nil -> create_unit(building, floor, line, size, bedrooms)
            result -> result
        end
    end

    private do
        def create_unit(building, floor, line, size, bedrooms) do
            {:ok, created_unit} = StuytownRents.Repo.insert(%StuytownRents.Unit{
                building: building,
                floor: floor,
                line: line,
                size: elem(Integer.parse(size), 0),
                bedrooms: elem(Float.parse(bedrooms), 0)
            })
            created_unit
        end
    end
end