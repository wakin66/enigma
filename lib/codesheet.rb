ALPHA = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
MONTHS = [
    :Januar,
    :Februar,
    :März,
    :April,
    :Mai,
    :Juni,
    :Juli,
    :August,
    :September,
    :Oktober,
    :November,
    :Dezember
]

class Codesheet

    def initialize
        @header = Hash.new
        generate_header
        @sheet = generate_sheet
    end

    def render
        system('clear')
        setup_lines.each {|line| puts line}
        return true
    end

    private

    attr_reader :header, :sheet

    def generate_header
        system('clear')
        print "What month and year do you need?(MMYYYY)"
        input = gets.chomp!.downcase
        year = input.slice!(2..-1)
        @header[:month] = input.to_i
        @header[:year] = year.to_i
    end

    def generate_sheet
        #look into using Integer#down_to
        days = Hash.new
        month_days.downto(1) do |day|
            days[day] = Hash.new
            days[day][:walzenlage] = generate_Walzenlage
            days[day][:ringstellung] = generate_Ringstellung
            days[day][:steckerverbindungen] = generate_Steckerverbindungen
            days[day][:kenngruppen] = generate_Kenngruppen
        end
        return days
    end

    def month
        return header[:month]

    end

    def year
        return header[:year]
    end

    def generate_Walzenlage #Rollers
        walzenlage = Array.new
        while walzenlage.length < 3
            srand
            roller = rand(5)+1
            walzenlage << roller if !walzenlage.include?(roller)
        end
        return walzenlage
    end

    def generate_Ringstellung #Ring Settings
        ringstellung = Array.new
        3.times do
            srand
            ringstellung << rand(26)+1
        end
        return ringstellung
    end

    def generate_Steckerverbindungen #Plugboard Settings
        alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        steckerverbindungen = Array.new
        10.times do
            srand
            position_0 = alpha.slice!(alpha[rand(alpha.length)])
            position_1 = alpha.slice!(alpha[rand(alpha.length)])
            steckerverbindungen << position_0+position_1
        end
        return steckerverbindungen
    end

    def generate_Kenngruppen #Identity Groups
        kenngruppen = Array.new
        4.times do
            srand
            position_0  = rand(26)
            position_1  = rand(26)
            position_2  = rand(26)
            kenngruppen << ALPHA[position_0]+ALPHA[position_1]+ALPHA[position_2]
        end
        return kenngruppen
    end

    def leap_year?
        return false if year%4 != 0
        return false if year%100 == 0 && year%400 != 0
        return true
    end

    def month_days
        months = [1,3,5,7,8,10,12]
        if month == 2
            leap_year? ? (return 29) : (return 28)
        end
        return 31 if months.include?(month)
        return 30
    end

    def setup_lines
        numerals = ["\u2160","\u2161","\u2162","\u2163","\u2164",]
        lines = Array.new
        lines << "GEHEIM!                    SONDER-MASCHINENSCHLUSSEL                     #{MONTHS[month-1]} #{year}"
        lines << "--------------------------------------------------------------------------------------"
        lines << "| Tag | Walzenlage |  Ringstellung |      Steckerverbindungen      |   Kenngruppen   |"
        lines << "--------------------------------------------------------------------------------------"
        sheet.each do |key,value|
            date = key > 9 ? key : "0"+key.to_s
            rollers = ""
            value[:walzenlage].each.with_index do |rotor, idx|
                rollers += "#{numerals[rotor-1]}"
                rollers += "   " if idx < 2
            end
            rings = ""
            value[:ringstellung].each.with_index do |ring, idx|
                rings += "#{ring > 9 ? ring : "0"+ring.to_s}"
                rings += "  " if idx < 2
            end
            plugs = ""
            value[:steckerverbindungen].each.with_index do |plug, idx|
                plugs += "#{plug}"
                plugs += " " if idx < 9
            end
            groups = ""
            value[:kenngruppen].each.with_index do |group, idx|
                groups += "#{group}"
                groups += " " if idx < 3
            end
            lines << "| #{date}  | #{rollers}  |   #{rings}  | #{plugs} | #{groups} |"
        end
        lines << "--------------------------------------------------------------------------------------"
        return lines
    end

end

if __FILE__ == $PROGRAM_NAME
    codesheet = Codesheet.new
    codesheet.render
end