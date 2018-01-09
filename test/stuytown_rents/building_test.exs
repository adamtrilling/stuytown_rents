defmodule StuytownRents.BuildingTest do
    use ExUnit.Case
    import StuytownRents.Building
    
    describe "generate_address/2" do
        test "correctly determines the oval" do
            {property, number} = parse_code("NYST31-020")
            assert generate_address(property, number) == "20 Stuy Oval"
        end

        test "correctly determines peter cooper rd" do
            {property, number} = parse_code("NYPC21-002")
            assert generate_address(property, number) == "2 Peter Cooper Rd"
        end

        test "correctly determines 14th St" do
            {property, number} = parse_code("NYST31-651")
            assert generate_address(property, number) == "651 E 14th St"

            {property, number} = parse_code("NYST31-405")
            assert generate_address(property, number) == "405 E 14th St"
        end

        test "correctly determines 23rd St" do
            {property, number} = parse_code("NYPC21-440")
            assert generate_address(property, number) == "440 E 23rd St"
        end

        test "correctly determines 20th St" do
            {property, number} = parse_code("NYST31-450")
            assert generate_address(property, number) == "450 E 20th St"

            {property, number} = parse_code("NYPC21-441")
            assert generate_address(property, number) == "441 E 20th St"
        end

        test "correctly determines 1 Ave" do
            {property, number} = parse_code("NYST31-280")
            assert generate_address(property, number) == "280 1st Ave"

            {property, number} = parse_code("NYPC21-350")
            assert generate_address(property, number) == "350 1st Ave"
        end

        test "correctly determines Ave C" do
            {property, number} = parse_code("NYST31-309")
            assert generate_address(property, number) == "309 Ave C"
        end
    end
end