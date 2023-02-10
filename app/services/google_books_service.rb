class GoogleBooksService
  def self.conn
    Faraday.new(url: 'https://www.googleapis.com') do |f|
      f.params['key'] = ENV['google_books_api_key']
    end
  end

  def self.search(title)
    response = conn.get('/books/v1/volumes') do |req|
      req.params['q'] = title
      req.params['intitle'] = title
    end
    json = JSON.parse(response.body, symbolize_names: true)
    json[:items].map { |book| select_data(book) }
  end

  def self.select_data(json)
    if json[:volumeInfo][:authors].nil? || json[:volumeInfo][:imageLinks].nil?
      nil
    else
      data = {
              title: json[:volumeInfo][:title],
              isbn: json[:volumeInfo][:industryIdentifiers][0][:identifier],
              author: json[:volumeInfo][:authors][0],
              image_url: json[:volumeInfo][:imageLinks][:thumbnail],
              page_count: json[:volumeInfo][:pageCount],
              summary: json[:volumeInfo][:description]
            }
      
      data.values.any? { |v| v.nil? } ? nil : data
    end
  end
end