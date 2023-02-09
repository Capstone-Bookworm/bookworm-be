# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


adelle = User.create(user_name: "Adelle", location: "Maine", email_address: "adelle@example.com")
short = Book.create(isbn: "9780307885166", title: "A Short History Of Nearly Everything", author: "Bill Bryson", image_url: "http://books.google.com/books/content?id=GbWp8QFX1K0C&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api", page_count: 876, summary: "This new edition of the acclaimed bestseller")
queen = Book.create(isbn: "9781501191428", title: "The Lost Queen", author: "Signe Pike", image_url: "http://books.google.com/books/content?id=x7GWDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api", page_count: 576, summary: "Outlander meets Camelot")
witches = Book.create(isbn: "9780143119685", title: "A Discovery of Witches", author: "Deborah Harkness", image_url: "http://books.google.com/books/content?id=UkSLDQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api", page_count: 610, summary: "Book one of the New York Times-bestselling All Souls trilogy")
adelle.books << short
adelle.books << queen
adelle.books << witches

amanda = User.create(user_name: "Amanda", location: "Colorado", email_address: "amanda@example.com")
left = Book.create(isbn: "9780143111597", title: "The Left Hand of Darkness", author: "Ursula K. Le Guin", image_url: "http://books.google.com/books/content?id=f9QiDQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api", page_count: 290, summary: "A deluxe hardcover edition of the queen of science fiction\'s trailblazing novel about a planet full of genderless beings—part of Penguin Galaxy.")
overstory = Book.create(isbn: "9780393635539", title: "The Overstory: A Novel", author: "Richard Powers", image_url: "http://books.google.com/books/content?id=_zQsDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api", page_count: 512, summary: "Winner of the Pulitzer Prize in Fiction")
ruby = Book.create(isbn: "9780321721334", title: "Practical Object-oriented Design in Ruby", author: "Sandi Metz", image_url: "http://books.google.com/books/content?id=rk9sAQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api", page_count: 272, summary: "The Complete Guide to Writing More Maintainable, Manageable, Pleasing, and Powerful Ruby Applications")
amanda.books << left
amanda.books << overstory
amanda.books << ruby
UserBook.where(user: adelle, book: witches).update(borrower_id: amanda.id, status: 1)


joshua = User.create(user_name: "Joshua", location: "Colorado", email_address: "joshua@example.com")
elsewhere = Book.create(isbn: "0312367465", title: "Elsewhere", author: "Gabrielle Zevin", image_url: "http://books.google.com/books/content?id=dR4EnwEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api", page_count: 304, summary: "After fifteen-year-old Liz Hall is hit by a taxi and killed, she finds herself in a place that is both like and unlike Earth, where she must adjust to her new status and figure out how to \"live.\" An ALA Notable Children's Book. Reprint. 75,000 first printing.")
martian = Book.create(isbn: "354040743X", title: "The Martian", author: "Andy Weir", image_url: "http://books.google.com/books/content?id=OPAgEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api", page_count: 482, summary: "#1 NEW YORK TIMES BESTSELLER • “Brilliant . . . a celebration of human ingenuity [and] the purest example of real-science sci-fi for many years . . . ")
joshua.books << elsewhere
joshua.books << martian
UserBook.where(user: amanda, book: overstory).update(borrower_id: joshua.id, status: 1)
UserBook.where(user: amanda, book: left).update(borrower_id: joshua.id, status: 1)


lauren = User.create(user_name: "Lauren", location: "Colorado", email_address: "lauren@example.com")
seven = Book.create(isbn: "176110294X", title: "The Seven Husbands of Evelyn Hugo", author: "Taylor Jenkins Reid", image_url: "http://books.google.com/books/content?id=5KlizgEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api", page_count: 400, summary: "The entrancing story of a reclusive Hollywood starlet")
sins = Book.create(isbn: "0578537419", title: "Sins and Cigarettes", author: "Makenna Misuraco", image_url: "http://books.google.com/books/content?id=XU4WxwEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api", page_count: 208, summary: "A collection of poetry")
tuesdays = Book.create(isbn: "9780307414090", title: "Tuesdays with Morrie", author: "Mitch Albom", image_url: "http://books.google.com/books/content?id=z2z_6hLoPmgC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api", page_count: 224, summary: "A special 25th anniversary edition")
lauren.books << seven
lauren.books << sins
lauren.books << tuesdays
UserBook.where(user: lauren, book: tuesdays).update(borrower_id: adelle.id, status: 2)
UserBook.where(user: adelle, book: queen).update(borrower_id: lauren.id, status: 3)


naomi = User.create(user_name: "Naomi", location: "Colorado", email_address: "naomi@example.com")
naomi.books << tuesdays
UserBook.where(user: lauren, book: seven).update(borrower_id: naomi.id, status: 1)
UserBook.where(user: amanda, book: ruby).update(borrower_id: naomi.id, status: 3)


rich = User.create(user_name: "Rich", location: "South Dakota", email_address: "rich@example.com")
moon = Book.create(isbn: "9780440001355", title: "The Moon Is a Harsh Mistress", author: "Robert A. Heinlein", image_url: "http://books.google.com/books/content?id=cMZiDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api", page_count: 402, summary: "For fans of Artemis—the visionary tour de force")
sovereign = Book.create(isbn: "9781439144732", title: "The Sovereign Individual", author: ["James Dale Davison", "Lord William Rees-Mogg"], image_url: "http://books.google.com/books/content?id=gxDADwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api", page_count: 454, summary: "Two renowned investment advisors of the bestseller")
carnivore = Book.create(isbn: "9781628603507", title: "The Carnivore Diet", author: "Shawn Baker", image_url: "http://books.google.com/books/content?id=YUi4DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api", page_count: 224, summary: "Shawn Baker's Carnivore Diet")
rich.books << moon
rich.books << sovereign
rich.books << carnivore
UserBook.where(user: naomi, book: tuesdays).update(borrower_id: rich.id, status: 3)
UserBook.where(user: joshua, book: martian).update(borrower_id: rich.id, status: 1)
UserBook.where(user: rich, book: carnivore).update(borrower_id: naomi.id, status: 1)

sage = User.create(user_name: "Sage", location: "California", email_address: "sage@example.com")
power = Book.create(isbn: "9781577313113", title: "The Power of Now", author: "Eckhart Tolle", image_url: "http://books.google.com/books/content?id=sQYqRCIhFAMC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api", page_count: 256, summary: "To make the journey into the Now")
sage.books << power
UserBook.where(user: sage, book: power).update(borrower_id: rich.id, status: 2)
UserBook.where(user: joshua, book: elsewhere).update(borrower_id: sage.id, status: 3)