class Country
  attr_accessor :name, :confirmed_cases, :overall_deaths, :recoveries
  @@records = []

  def initialize(country_name, country_cases, country_deaths, country_recoveries)
    @name = country_name
    @confirmed_cases = country_cases
    @overall_deaths = country_deaths
    @recoveries = country_recoveries

    @@records << self
  end

#class method
  def self.all
    @@records
  end


end

# tests
# andorra = Country.new("Andorra", "11", "14", "0")

# puts "There are this many cases in #{andorra.name}: " + andorra.confirmed_cases
# puts Country.all
