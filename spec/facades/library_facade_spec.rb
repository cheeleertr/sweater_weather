require 'rails_helper'

describe LibraryFacade do
  context "instance methods" do
    context "#new.books_by_search_and_limit" do
      it "returns books data", :vcr do
        books_data = LibraryFacade.new.books_by_search_and_limit("denver,co", "5")
        
        expect(books_data).to be_a Hash
        expect(books_data).to have_key(:total_books_found)
        expect(books_data).to have_key(:books)
        expect(books_data[:books]).to all(be_a(Book))
      end
    end
  end
end