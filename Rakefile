require 'rake/clean'

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

task default: 'actionsprout-history.ppm'

directory 'repos'

rule '.git' => ['repos'] do |t|
  sh 'git', 'clone', "https://github.com/ActionSprout/#{t.name.pathmap('%f')}", t.name
end

rule '.rawlog' => ['.git'] do |t|
  sh 'gource', t.source, '--output-custom-log', t.name
end

rule '.log' => ['.rawlog'] do |t|
  sh "sed -E 's#(.+)\\|#\\1|/#{t.name.pathmap('%n')}#' #{t.source} > #{t.name}"
end

logs = repos.pathmap('repos/%p.log')
CLEAN.include logs
CLEAN.include repos.pathmap('repos/%p.rawlog')
CLEAN << 'gource-log.txt'
file 'gource-log.txt' => logs do
  sh "cat #{logs} | sort -n > gource-log.txt"
end

CLEAN << 'actionsprout-history.txt'
file 'actionsprout-history.txt' => ['gource-log.txt'] do
  sh 'cat gource-log.txt > actionsprout-history.txt'
end

task show: ['actionsprout-history.txt', 'gource.config'] do
  sh 'gource', 'actionsprout-history.txt', '--load-config', 'gource.config'
end

rule '.ppm' => ['.txt', 'gource.config'] do |t|
  sh 'gource', t.source, '--load-config', 'gource.config' #, '--output-ppm-stream', t.name
end

