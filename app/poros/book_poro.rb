class BookPoro
  attr_reader :title,
              :isbn,
              :author,
              :image_url,
              :page_count,
              :summary

  def initialize(book_data)
    @title = book_data[:title]
    @isbn = book_data[:isbn]
    @author = book_data[:author]
    @image_url = book_data[:image_url]
    @page_count = book_data[:page_count]
    @summary = book_data[:summary]  
    end
end