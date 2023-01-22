class CLI

  attr_accessor :user

  def run
    Scraper.scrape_information
    User.seed
    system('clear')
    greeting
    login_or_signup
    while menu != 'exit' 
    end
    end_program
  end

  def login_or_signup
    response = ''

    while response != 'login' && response != 'signup'
      puts "Do you wish to login, or signup?"
      response = gets.chomp
    end

    if response == 'login'
      login
    else
      signup
    end
  end


  def signup 
    puts "Welcome new user."
    puts "Enter the username you'd like."
    username = gets.chomp
    puts "Now enter a password you'd like to use."
    password = gets.chomp
    User.new(username, password)
    login

  end

  def login
    authenticated = false
    while authenticated != true
      puts "Please login."
      puts ">What is your username?"
      username = gets.chomp
      puts ">What is your password?"
      password = gets.chomp
      currUser = Auth.authenticate_user(User.all, username, password)
      if currUser
        puts "Login successful!"
        authenticated = true
        @user = currUser
        greet_user
      else
        puts "Login attempt failed."
      end
    end
  end


  def greeting
    puts "Welcome to the CLI covid tracker!"
  end
  
  def greet_user
    puts "Welcome #{@user.username}"
  end

  def end_program
    puts "See you later?"
  end

  def menu
    # asks the user which one they want?
    puts "Choose an option, or exit."
    # lists options
    list_options

    input = gets.chomp
    choose_option(input)
    return input
  end

  def list_options
    puts "1. Country total U.S. Information"
    puts "2. Print all state information"
    puts "3. Top 10 states with MOST confirmed cases"
    puts "4. Top 10 states with LEAST confirmed cases"
  end

  def choose_option(input)
    case input
    when "1"
      puts "Number 1 chosen"
      usa = Country.all[0]
      puts usa.name
      puts "Confirmed cases: #{usa.confirmed_cases}"
      puts "Overall Deaths: #{usa.overall_deaths}"
      puts "Recovered Cases: #{usa.recoveries}"

    when "2"
      puts "Number 2 chosen"
      State.all.each_with_index do |state, i|
        puts "#{i + 1}. #{state.name} confirmed cases: #{state.confirmed_cases}"
      end
    when "3"
      puts "Number 3 chosen"
      State.all[0..10].each_with_index do |state, i|
        puts "#{i + 1}. #{state.name} confirmed cases: #{state.confirmed_cases}"
      end
    when "4"
      puts "Number 4 chosen"
      states = State.all.sort_by{|state| state.confirmed_cases}
      states[0..9].each_with_index do |state, i|
        puts "#{i + 1}. #{state.name} confirmed cases: #{state.confirmed_cases}"
      end
    end
  end
end
