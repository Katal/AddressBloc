require_relative '../models/address_book'

RSpec.describe AddressBook do 

	let(:book) {AddressBook.new}

	def check_entry(entry, expected_name, expected_number, expected_email)
    	expect(entry.name).to eql expected_name
    	expect(entry.phone_number).to eql expected_number
    	expect(entry.email).to eql expected_email
 	end

	describe "attributes" do
		it "should respond to entries" do
			expect(book).to respond_to(:entries)
		end

		it "should initialize entries as an array" do
			expect(book.entries).to be_a(Array)
		end

		it "should initialize entries as empty" do
			expect(book.entries.size).to eq(0)
		end
	end

	describe "#add_entry" do
		it "adds only one entry to the address book" do
			book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')

			expect(book.entries.size).to eq(1)
		end

		it "adds the correct information to entries" do
			book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
			new_entry = book.entries[0]

			expect(new_entry.name).to eq('Ada Lovelace')
			expect(new_entry.phone_number).to eq('010.012.1815')
			expect(new_entry.email).to eq('augusta.king@lovelace.com')
		end
	end

	describe "#remove_entry" do
		it "removes only one entry entirely from the address book" do
			#check this line above for trouble
			book.remove_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')

			expect(book.entries.size).to eq(0)
		end

		# it "returns not found" do
		# 	book = AddressBook.new
		# 	book.remove_entry('Bonquesha', '702.555.5555', 'bonquesha@gmail.com')

		# 	expect(book.remove_entry).to return("not found")???
		# end
	end

	describe "#import_from_csv" do
		#do you always have to build specific tests with specific data for your programs to test?
		it "imports the correct number of entries" do
			book.import_from_csv("entries.csv")
			book_size = book.entries.size
			expect(book_size).to eql 5
		end

		it "imports the 1st entry" do
       		book.import_from_csv("entries.csv")
       		# Check the first entry
       		entry_one = book.entries[0]
       		check_entry(entry_one, "Bill", "555-555-4854", "bill@blocmail.com")
		end

		it "imports the 2nd entry" do
       		book.import_from_csv("entries.csv")
       		# Check the second entry
       		entry_two = book.entries[1]
	       	check_entry(entry_two, "Bob", "555-555-5415", "bob@blocmail.com")
	    end
 
	    it "imports the 3rd entry" do
	       book.import_from_csv("entries.csv")
	       # Check the third entry
	       entry_three = book.entries[2]
	       check_entry(entry_three, "Joe", "555-555-3660", "joe@blocmail.com")
	    end
 
	    it "imports the 4th entry" do
	       book.import_from_csv("entries.csv")
	       # Check the fourth entry
	       entry_four = book.entries[3]
	       check_entry(entry_four, "Sally", "555-555-4646", "sally@blocmail.com")
	    end
 
	    it "imports the 5th entry" do
	       book.import_from_csv("entries.csv")
	       # Check the fifth entry
	       entry_five = book.entries[4]
	       check_entry(entry_five, "Sussie", "555-555-2036", "sussie@blocmail.com")
	    end

		it "imports the correct number of entries from second CSV" do
			book.import_from_csv("entries_2.csv")
			book_size = book.entries.size
			expect(book_size).to eql 3
		end

		## COME BACK TO THIS AFTER NEXT CHECKPOINT

		# it "imports the 1st entry from csv 2, the sixth entry" do
		# 	book.import_from_csv("entries_2.csv")
		# 	#check first entry from book 2
		# 	entry_six = book.entries[5]
		# 	check_entry(entry_six, "Tamara", "702-555-5555", "tammy@blocmail.com")
		# end

		# it "imports the 2nd entry from csv 2, the seventh entry in total" do
		# 	book.import_from_csv("entries_2.csv")
		# 	#check first entry from book 2
		# 	entry_seven = book.entries[6]
		# 	check_entry(entry_seven, "Ursula", "702-555-5551", "ursula@blocmail.com")
		# end

		# it "imports the 3rd entry from csv 2, the eigth entry total" do
		# 	book.import_from_csv("entries_2.csv")
		# 	#check first entry from book 2
		# 	entry_eight = book.entries[7]
		# 	check_entry(entry_eight, "Zach", "750-555-5555", "zach@blocmail.com")
		# end

	end


end
