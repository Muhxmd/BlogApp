medium_categories = [
  # Technology & Software
  "Artificial Intelligence", "Blockchain", "Data Science", "Gadgets", "Machine Learning",
  "Programming", "Software Engineering", "Technology", "Cybersecurity", "Web Development",
  
  # Business & Work
  "Business", "Entrepreneurship", "Leadership", "Marketing", "Productivity", 
  "Startups", "Freelancing", "Economy", "Management",
  
  # Arts, Culture & Media
  "Art", "Books", "Culture", "Design", "Film", "Music", 
  "Photography", "Podcasts", "Writing", "Humor",
  
  # Personal Development & Health
  "Health", "Mental Health", "Fitness", "Self Improvement", "Personal Development",
  "Relationships", "Family", "Mindfulness", "Spirituality",
  
  # World & Science
  "Education", "History", "Philosophy", "Politics", "Science", 
  "Society", "Environment", "Nature", "Travel"
]

puts "Cleaning up old categories..."
# Optional: Uncomment the next line if you want to wipe existing categories every time you seed
# Category.destroy_all 

puts "Seeding Medium categories..."

medium_categories.each do |category_name|
  # find_or_create_by ensures we don't create duplicates if you run the seed command twice
  Category.find_or_create_by!(name: category_name)
end

puts "Successfully seeded #{Category.count} categories!"