require 'rubygems'
# require 'sitemap_generator' TODO: Sitemap generator
require 'mysql2'
require 'uri'
require 'seed_dump'

# Dirs
project_seeds_dir = "db/seeds/"
img_dir = "img/"

#
client = Mysql2::Client.new(:host     => "localhost",
                            :username => "root",
                            :password => "root",
                            :port     => "8889",
                            :database => "wordpress",
                            :socket   => "/Applications/MAMP/tmp/mysql/mysql.sock");

client.query("SELECT * FROM `wp_posts` WHERE `post_type` = 'post'").each do |row|

	puts "Importing Article " + row["post_title"]

	# t.string   "name"
	# t.text     "content"
	# t.text     "excerpt"
	# t.text     "categories"
	# t.datetime "created_at", null: false
	# t.datetime "updated_at", null: false
	# t.string   "shortname"

	first = true
	categories = ""
	client.query("SELECT * FROM `wp_term_relationships` WHERE `object_id` = '" + row["ID"].to_s + "' ").each do |relationship|
		puts "Iterating relationship " + relationship["object_id"].to_s
		client.query("SELECT * FROM `wp_terms` WHERE `term_id` = '" + relationship["term_taxonomy_id"].to_s + "' ").each do |term|
			puts "Iterating Term " + term["name"]
			if first
				categories = term["name"]
				first = false
			elsif first == false
				categories = categories + ", " + term["name"]
			end

			if Category.exists?(name: term["name"]) == false
				Category.create(name: term["name"], code: term["slug"])
			end
		end
	end

	# filtered = HTMLPage.new :contents => row["post_content"]
	# filtered = ReverseMarkdown.convert(input, unknown_tags: :raise, github_flavored: true)
	filtered = row["post_content"]

	Article.create(name: row["post_title"], excerpt: row["post_excerpt"], created_at: row["post_date"],
	               content: filtered, shortname: row["post_name"],  updated_at: row["post_modified"],
                 categories: categories)

end


# ISAAC / OCHRE
Project.create(categories: "Java, JavaFX, Maven, Maven MOJO", order: 0, displayed: true, created_at: Time.now, updated_at: Time.now,
               name: "ISAAC Release Exporters", content: File.read(project_seeds_dir + "apelon-va-export.php"), summary: "", img_file_name: "")
Project.create(categories: "Python, Maven", order: 0, displayed: true, created_at: Time.now, updated_at: Time.now,
               name: "OCHCRE - Helper Scripts for Maven in Python", content: File.read(project_seeds_dir + "isaac-python-scripts.php"), summary: "", img_file_name: "")


# PHP / MySQL
Project.create(categories: "", order: 0, displayed: true, created_at: Time.now, updated_at: Time.now,
               name: "Campus Swap.Net - College Student Market Place", content: File.read(project_seeds_dir + "campusswap.php"), summary: "", img_file_name: "")

Project.create(categories: "", order: 0, displayed: true, created_at: Time.now, updated_at: Time.now,
               name: "The Bethlehem Vineyard", content: File.read(project_seeds_dir + "vineyard.php"), summary: "", img_file_name: "")
Project.create(categories: "PHP, MySQL, Updated", order: 0, displayed: true, created_at: Time.now, updated_at: Time.now,
               name: "The Cocktail Chemist", content: File.read(project_seeds_dir + "cocktail.php"), summary: "", img_file_name: "")
Project.create(categories: "PHP, MySQL, Bootstrap", order: 0, displayed: true, created_at: Time.now, updated_at: Time.now,
               name: "Woodbury Flea Market Website", content: File.read(project_seeds_dir + "woodburyflea.php"), summary: "", img_file_name: "")
Project.create(categories: "PHP, MySQL, Bootstrap", order: 0, displayed: true, created_at: Time.now, updated_at: Time.now,
               name: "Athan Kaloidis Memorial Foundation", content: File.read(project_seeds_dir + "athankaloidis.php"), summary: "", img_file_name: "")


# Applescripts
Project.create(categories: "Mac OSX, New", order: 0, displayed: true, created_at: Time.now, updated_at: Time.now,
               name: "Applescripts", content: File.read(project_seeds_dir + "applescripts.php"), summary: "", img_file_name: "")

# C++
Project.create(categories: "C++, OpenGL", order: 0, displayed: true, created_at: Time.now, updated_at: Time.now,
               name: "C++ 3D City Building Fly-Through", content: File.read(project_seeds_dir + "glfly.php"), summary: "", img_file_name: "")
Project.create(categories: "C++, OpenGL", order: 0, displayed: true, created_at: Time.now, updated_at: Time.now,
               name: "C++ OpenGL 3D Cube", content: File.read(project_seeds_dir + "spinningcube.php"), summary: "", img_file_name: "")

# Java
Project.create(categories: "Java", order: 3, displayed: true, created_at: Time.now, updated_at: Time.now,
               name: "Java Directory App",
               content: File.read(project_seeds_dir + "javadirectory.php"), summary: "", img_file_name: "")
Project.create(categories: "Java", order: 3, displayed: true, created_at: Time.now, updated_at: Time.now,
               name: "Java Merge Sorter",
               content: File.read(project_seeds_dir + "javamerge.php"), summary: "", img_file_name: "")
Project.create(categories: "Java", order: 3, displayed: true, created_at: Time.now, updated_at: Time.now,
               name: "Java Bin Search",
               content: File.read(project_seeds_dir + "javabin.php"), summary: "", img_file_name: "")
Project.create(categories: "Java", order: 3, displayed: true, created_at: Time.now, updated_at: Time.now,
               name: "Java File Parser",
               content: File.read(project_seeds_dir + "javafile.php"), summary: "", img_file_name: "")
Project.create(categories: "Java, Java EE", order: 2, displayed: true, created_at: Time.now, updated_at: Time.now,
               name: "Java EE EJB SOAP Service Wrapper around Google GeoCode Rest API",
               content: File.read(project_seeds_dir + "javageocode.php"), summary: "", img_file_name: "")
Project.create(categories: "Java, Java EE", order: 1, displayed: true, created_at: Time.now, updated_at: Time.now,
               name: "Java EE Reindeer REST Web Service",
               content: File.read(project_seeds_dir + "javaeereindeer.php"), summary: "", img_file_name: "")
Project.create(categories: "Java, Java EE", order: 0, displayed: true, created_at: Time.now, updated_at: Time.now,
               name: "Java EE SOAP JAX-WS Digital Signature Tool Web Service",
               content: File.read(project_seeds_dir + "javaeedigsig.php"), summary: "", img_file_name: "")

# MIPS
Project.create(categories: "MIPS", order: 0, displayed: true, created_at: Time.now, updated_at: Time.now,
               name: "MIPS Single Precision Floating Point Unit Array of User Input then Output", content: File.read(project_seeds_dir + "mipslargernumbers.php"), summary: "", img_file_name: "")
Project.create(categories: "MIPS", order: 0, displayed: true, created_at: Time.now, updated_at: Time.now,
               name: "MIPS Program That Swaps the Case of Each Letter In a String", content: File.read(project_seeds_dir + "mipscaseswap.php"), summary: "", img_file_name: "")
Project.create(categories: "MIPS", order: 0, displayed: true, created_at: Time.now, updated_at: Time.now,
               name: "MIPS Random Number Generator Function Stored In Single Precision Floating Point Unit Array", content: File.read(project_seeds_dir + "mipsfpu.php"), summary: "", img_file_name: "")
Project.create(categories: "MIPS", order: 0, displayed: true, created_at: Time.now, updated_at: Time.now,
               name: "MIPS Single Precision Positive Addit Function", content: File.read(project_seeds_dir + "positiveaddit.php"), summary: "", img_file_name: "")

# SML
Project.create(categories: "SML", order: 0, displayed: true, created_at: Time.now, updated_at: Time.now,
               name: "SML Functions: list value member checker and list union", content: File.read(project_seeds_dir + "smlfunctions2.php"), summary: "", img_file_name: "")
Project.create(categories: "SML", order: 3, displayed: true, created_at: Time.now, updated_at: Time.now,
               name: "SML Functions: nth power, smallest of 3 numbers and list value cycle", content: File.read(project_seeds_dir + "smlfunctions1.php"),
               summary: "", img_file_name: "")
Project.create(categories: "SML", order: 2, displayed: true, created_at: Time.now, updated_at: Time.now,
               name: "SML Functions: polynomial evaluator and powerset creator", content: File.read(project_seeds_dir + "smlfunctions3.php"),
               summary: "", img_file_name: "")

# C
Project.create(categories: "C, YACC", order: 1, displayed: true, created_at: Time.now, updated_at: Time.now,
               name: "YACC BISON Simple Calculator", content: File.read(project_seeds_dir + "yaccgrammar.php"),
               summary: "", img_file_name: "")

# Circuit
Project.create(categories: "Circuit", order: 0, displayed: true, created_at: Time.now, updated_at: Time.now,
               name: "4 bit Full Adder Circuit (Logism)", content: File.read(project_seeds_dir + "4bit.php"),  summary: "",
               img_file_name: "")

## Categories
# Project.all.each as |project|
#
#  end