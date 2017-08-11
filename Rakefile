# Rake.application.options.trace_rules = true

repos = Rake::FileList.new(%w[
  fern
  pine
  juniper
  waterleaf
  as-developers
  as-developers.wiki
  as_jwt_auth
  coding-styles
  crabgrass
  Snapdragon
  action_sprout-facebook
  hardhack
  ivy
  huckleberry
  starflower
  pixie_eyes
  lily
  eve
  sunflower
  orchid
  gideon
  salmonberry
  facebook
  willow-node
  PineDrops
  cottonwood
  dandelion
  bullseye
  willow
  clover
  willow2
  fishnet
  salal
  gooseberry
])

task default: 'gource-log.txt'

directory 'repos'

rule '.git' => ['repos'] do |t|
  sh 'git', 'clone', "https://github.com/ActionSprout/#{t.name.pathmap('%f')}", t.name
end

rule '.log' => ['.git'] do |t|
  sh 'gource', t.source, '--output-custom-log', t.name
end

logs = repos.pathmap('repos/%p.log')
file 'gource-log.txt' => logs do
  sh "cat #{logs} | sort -n > gource-log.txt"
end

rule '.ppm' => ['.txt'] do
  sh 'gource'
end

# gource \
#   -1280x720 \
#   --seconds-per-day 0.01 \
#   --font-size 20 \
#   --hide filenames,dirnames \
#   --date-format '%B %Y' \
#   --title "ActionSprout code changes" \
#   --max-file-lag 0.1 \
#   --user-image-dir .git/avatar/ \
#   --user-scale 4 \
#   --highlight-users \
#   --camera-mode overview \
#   --file-filter '/(images\/img\/(datatables|oxygen))|vendor/' \

