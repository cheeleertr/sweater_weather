require 'rails_helper'

describe "Book-Search API" do
  context "get /api/v1/book-search" do
    it "returns book search JSON data with the correct structure and values", :vcr do

      get '/api/v1/book-search?location=denver,co&quantity=5'

      expect(response).to be_successful
      expect(response.status).to eq(200)
      
      book_search = JSON.parse(response.body, symbolize_names: true)

      expect(book_search).to have_key(:data)
      expect(book_search[:data]).to be_a(Hash)

      expect(book_search[:data]).to have_key(:id)
      expect(book_search[:data][:id]).to be_nil

      expect(book_search[:data]).to have_key(:type)
      expect(book_search[:data][:type]).to eq("books")

      expect(book_search[:data]).to have_key(:attributes)
      expect(book_search[:data][:attributes]).to be_a(Hash)

      expect(book_search[:data][:attributes]).to have_key(:destination)
      expect(book_search[:data][:attributes][:destination]).to be_a(String)

      expect(book_search[:data][:attributes]).to have_key(:total_books_found)
      expect(book_search[:data][:attributes][:total_books_found]).to be_a(Integer)

      expect(book_search[:data][:attributes]).to have_key(:forecast)
      expect(book_search[:data][:attributes][:forecast]).to be_a(Hash)

      expect(book_search[:data][:attributes][:forecast]).to have_key(:summary)
      expect(book_search[:data][:attributes][:forecast][:summary]).to be_a(String)

      expect(book_search[:data][:attributes][:forecast]).to have_key(:temperature)
      expect(book_search[:data][:attributes][:forecast][:temperature]).to be_a(String)

      books = book_search[:data][:attributes][:books]

      expect(books.count <= 5).to eq(true)

      books.each do |book|
        expect(book).to be_a(Hash)
        expect(book).to have_key(:isbn)
        # not all have isbn
        expect(book[:isbn]).to be_a(Array)
        expect(book).to have_key(:title)
        expect(book[:title]).to be_a(String)
        expect(book).to have_key(:publisher)
        # not all have publisher
        expect(book[:publisher]).to be_a(Array)
      end

    end
  end
end
