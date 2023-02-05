class BookPoro
  attr_reader :title,
              :isbn,
              :author,
              :image_url,
              :page_count,
              :summary

  def initialize(book_data)
    @title = book_data[:volumeInfo][:title]
    @isbn = book_data[:volumeInfo][:industryIdentifiers][0][:identifier]
    @author = book_data[:volumeInfo][:authors][0]
    @image_url = book_data[:volumeInfo][:imageLinks][:thumbnail]
    @page_count = book_data[:volumeInfo][:pageCount]
    @summary = book_data[:volumeInfo][:description]
  end
end