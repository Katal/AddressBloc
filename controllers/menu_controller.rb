require_relative '../models/address_book'

class MenuController
	attr_accessor :address_book

	def initialize
		@address_book = AddressBook.new
	end

	def main_menu
		puts "Main Menu - #{@address_book.entries.count} entries"
		puts "1 - View all entries"
		puts "2 - View specific entry number #?"
		puts "3 - Create an entry"
		puts "4 - Search for an entry"
		puts "5 - Import entries from a CSV"
		puts "6 - Exit"
		puts "7 - Detonate and delete entire address book"
		print "Enter your selection: "

		selection = gets.to_i
		puts selection
		case selection
		when 1
			system "clear"
			view_all_entries
			main_menu
		when 2
			system "clear"
			view_entry
			main_menu
		when 3
			system "clear"
			create_entry
			main_menu
		when 4
			system "clear"
			search_entry
			main_menu
		when 5
			system "clear"
			read_csv
			main_menu
		when 6
			puts "Good-bye!"
			exit(0)
		when 7
			system "clear"
			detonate
			main_menu
		else
			system "clear"
			puts "Sorry, that is not a valid input"
			main_menu
		end
	end

	def view_all_entries
		@address_book.entries.each do |entry|
     		system "clear"
     		puts entry.to_s
     		entry_submenu(entry)
     	end

     	system "clear"
     	puts "End of entries"
	end

	def view_entry
		system "clear"
		puts "Enter entry number"
		print "Entry #: "
		input = gets.chomp.to_i
		puts input

		@address_book.entries.each_with_index do |entry, index|
				puts index
				puts input
				puts "-----"
			if (index + 1) == input
				puts "Awesome! Found entry #{input}" 
				puts entry.to_s
				entry_submenu(entry)
			else
				puts "Bummer - Entry #{input} not found :("
			end

		end

		main_menu

	end

	# def search_entries
	# 	print "Search by name: "
 #     	name = gets.chomp
 #     	match = @address_book.binary_search(name)
 #     	system "clear"

	#      if match
	#        puts match.to_s
	#        search_submenu(match)
	#      else
	#        puts "No match found for #{name}"
	#      end

	# def iterative_search(name)
 #   		@entries.each do |entry|
 #   			if name == entry.name
 #   				return entry
 #   			end
 #   		end
   		
 #   		return nil

 #   	end
	 
	def create_entry
		system "clear"
	    puts "New AddressBloc Entry"
	    print "Name: "
	    name = gets.chomp
	    print "Phone number: "
	    phone = gets.chomp
	    print "Email: "
	    email = gets.chomp
	 
	    @address_book.add_entry(name, phone, email)
	 
	    system "clear"
	    puts "New entry created"
	end
	 
	def search_entry
		print "Search by name: "
     	name = gets.chomp
     	match = @address_book.iterative_search(name)
     	system "clear"

	     if match
	       puts match.to_s
	       search_submenu(match)
	     else
	       puts "No match found for #{name}. Make sure your entry is correctly spelled and capitalized." 
	     end
	end
	 
	def read_csv
     print "Enter CSV file to import: "
     file_name = gets.chomp

     if file_name.empty?
       system "clear"
       puts "No CSV file read"
       main_menu
     end

     begin
       entry_count = @address_book.import_from_csv(file_name).count
       system "clear"
       puts "#{entry_count} new entries added from #{file_name}"
     rescue
       puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
       read_csv
     end
	end

	def delete_entry(entry)
     	@address_book.entries.delete(entry)
     	puts "#{entry.name} has been deleted"
  	end

  	def edit_entry(entry)
     print "Updated name: "
     name = gets.chomp
     print "Updated phone number: "
     phone_number = gets.chomp
     print "Updated email: "
     email = gets.chomp

     entry.name = name if !name.empty?
     entry.phone_number = phone_number if !phone_number.empty?
     entry.email = email if !email.empty?

     system "clear"
     puts "Updated entry:"
     puts entry
   	end

   	def detonate
   		@address_book.entries.clear
   		puts "Address Book has been detonated"
   	end

	def entry_submenu(entry)
     puts "n - next entry"
     puts "d - delete entry"
     puts "e - edit this entry"
     puts "m - return to main menu"

     selection = gets.chomp
 
     case selection
     when "n"
     	#how does n have no code here and work??
     when "d"
     	 delete_entry(entry)
     when "e"
     	edit_entry(entry)
     	entry_submenu(entry)
     when "m"
       system "clear"
       main_menu
     else
       system "clear"
       puts "#{selection} is not a valid input"
       entries_submenu(entry)
     end
   end

    def search_submenu(entry)
     puts "\nd - delete entry"
     puts "e - edit this entry"
     puts "m - return to main menu"
     selection = gets.chomp
 
     case selection
     when "d"
       system "clear"
       delete_entry(entry)
       main_menu
     when "e"
       edit_entry(entry)
       system "clear"
       main_menu
     when "m"
       system "clear"
       main_menu
     else
       system "clear"
       puts "#{selection} is not a valid input"
       puts entry.to_s
       search_submenu(entry)
     end
   end

end
