users = {
  justcxx: "skillgrid",
  socucius: "test-task",
  efelikanfuzin: "skillgrid"
}

users.each do |name, repo|
  User.create(name: name, repo: repo)
end

repos = ["edavis10/redmine", "justCxx/sicp"]

repos.each do |repo|
  Project.create(repo: repo)
end
