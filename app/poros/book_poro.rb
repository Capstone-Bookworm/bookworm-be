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
    @author = book_author(book_data)
    @image_url = book_image(book_data)
    @page_count = book_data[:volumeInfo][:pageCount]
    @summary = book_data[:volumeInfo][:description]
  end

  def book_author(book_data)
    if book_data[:volumeInfo][:authors].nil?
      nil
    else
      book_data[:volumeInfo][:authors][0]
    end
  end

  def book_image(book_data)
    if book_data[:volumeInfo][:imageLinks].nil?
      nil
    else
      book_data[:volumeInfo][:imageLinks][:thumbnail]
    end
  end
end