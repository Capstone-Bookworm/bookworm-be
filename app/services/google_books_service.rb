class GoogleBooksService
  def self.conn
    Faraday.new(url: 'https://www.googleapis.com') do |f|
      f.params['key'] = ENV['google_books_api_key']
    end
  end

  def self.search(title, author)
    response = conn.get('/books/v1/volumes') do |req|
      req.params['q'] = title
      req.params['inauthor'] = author
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end