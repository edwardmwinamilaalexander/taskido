# Find or create the user
user = User.find_or_create_by!(email: "samaki@gmail.com") do |u|
  u.password = "samaki"
  u.password_confirmation = "samaki"
end

puts "Created user: samaki@gmail.com with password: samaki"

# Clear existing tasks and create new ones (optional)
user.tasks.destroy_all

# Create sample tasks
tasks = [
  # TO DO tasks
  { content: "Buy groceries for the week", state: "to_do", created_at: 2.hours.ago },
  { content: "Finish reading 'The Hobbit'", state: "to_do", created_at: 1.day.ago },
  { content: "Plan weekend trip", state: "to_do", created_at: 3.hours.ago },
  
  # DOING tasks
  { content: "Work on Rails project", state: "doing", created_at: 2.days.ago },
  { content: "Learn Bootstrap 5", state: "doing", created_at: 5.hours.ago },
  { content: "Prepare presentation", state: "doing", created_at: 1.day.ago },
  
  # DONE tasks
  { content: "Setup development environment", state: "done", created_at: 3.days.ago },
  { content: "Complete Ruby basics course", state: "done", created_at: 1.week.ago },
  { content: "Fix login bug", state: "done", created_at: 2.days.ago }
]

tasks.each do |task_attrs|
  user.tasks.create!(task_attrs)
end

puts "Created #{user.tasks.count} sample tasks for samaki@gmail.com"
puts "Task breakdown:"
puts "  TO DO: #{user.tasks.where(state: 'to_do').count}"
puts "  DOING: #{user.tasks.where(state: 'doing').count}"
puts "  DONE: #{user.tasks.where(state: 'done').count}"