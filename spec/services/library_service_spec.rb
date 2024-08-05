require 'rails_helper'

describe LibraryService do
  context "class methods" do
    context "#books_by_search_and_limit" do
      it "returns books data", :vcr do
        search = LibraryService.books_by_search_and_limit("denver,co","5")

        expect(search).to be_a Hash
        expect(search).to have_key(:numFound)
        expect(search[:numFound]).to be_a Integer

        books_data = search[:docs]

        expect(books_data).to be_a Array
        expect(books_data.count <= 5).to eq(true)
        
        books_data.each do |book_data|
          expect(book_data).to have_key(:isbn)
          expect(book_data[:isbn]).to be_a Array

          expect(book_data).to have_key(:title)
          expect(book_data[:title]).to be_a String

          expect(book_data).to have_key(:publisher)
          expect(book_data[:publisher]).to be_a Array
        end
      end
    end
  end
end