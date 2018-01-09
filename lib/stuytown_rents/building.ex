defmodule StuytownRents.Building do
    use Ecto.Schema
    use Private

    schema "buildings" do
        has_many :units, StuytownRents.Unit
        field :code, :string
        field :address, :string
        field :property, :string
    end

    def find_or_create(code) do
        case StuytownRents.Repo.get_by(StuytownRents.Building, code: code) do
            nil -> create_building(code)                
            result -> result
        end
    end

    private do
        def parse_code(code) do
            [_, property, number] = Regex.run(~r/NY(PC|ST)\d\d-(\d+)/, code)
            {property, elem(Integer.parse(number), 0)}
        end

        def generate_address("ST", number) when number >= 400 do
            if rem(number, 2) == 0 do
                "#{number} E 20th St"
            else
                "#{number} E 14th St"
            end
        end

        def generate_address("PC", number) when number >= 400 do
            if rem(number, 2) == 0 do
                "#{number} E 23rd St"
            else
                "#{number} E 20th St"
            end
        end

        def generate_address("ST", number) when number < 100, do: "#{number} Stuy Oval"
        def generate_address("PC", number) when number < 100, do: "#{number} Peter Cooper Rd"

        def generate_address(_, number) do
            if rem(number, 2) == 0 do
                "#{number} 1st Ave"
            else
                "#{number} Ave C"
            end
        end

        defp create_building(code) do
            {property, number} = parse_code(code)

            building = %StuytownRents.Building{
                code: code,
                property: property,
                address: generate_address(property, number)
            }
            
            {:ok, created_building} = StuytownRents.Repo.insert(building)
            created_building
        end
    end
end