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

transformations = {
  "Andrea" => "Andrea Frost",
  "kculafic" => "Krsto Culafic",
  "Kyle W. Rader" => "Kyle Rader",
  "shrapnle" => "Shawn Kemp",
  "nathancarnes" => "Nathan Carnes",
  "amiel\\/timwhite47" => "Amiel Martin and Tim White",
  "evanfrazier" => "Evan Frazier",
}

task default: 'actionsprout-history.mp4'

git_repos = repos.pathmap('repos/%p.git')
task update: git_repos do
  git_repos.each do |repo|
    sh "(cd #{repo}; git reset --hard; git pull --ff-only)"
  end
end

directory 'repos'

rule '.git' => ['repos'] do |t|
  sh 'git', 'clone', "https://github.com/ActionSprout/#{t.name.pathmap('%f')}", t.name
end

CLEAN.include repos.pathmap('repos/%p.rawlog')
rule '.rawlog' => ['.git'] do |t|
  sh 'gource', t.source, '--output-custom-log', t.name
end

logs = repos.pathmap('repos/%p.log')
CLEAN.include logs
rule '.log' => ['.rawlog'] do |t|
  sh "cat #{t.source} | sed -E 's#(.+)\\|#\\1|/#{t.name.pathmap('%n')}#' > #{t.name}"
end

CLEAN << 'gource-log.txt'
file 'gource-log.txt' => logs do
  # This extra line helps group the different repos with the hide-root=false
  # option set
  sh "echo '1328651952|Adrian Pike|A|/pledgie' > gource-log.txt"
  sh "cat #{logs} | sort -n >> gource-log.txt"
end

CLEAN << 'actionsprout-history.txt'
file 'actionsprout-history.txt' => ['gource-log.txt'] do
  replace_with_sed = "sed -E 's/\\|%s\\|/|%s|/'"

  commands = transformations.map do |before, after|
    replace_with_sed % [before, after]
  end

  commands << "sed -E 's/[\\&\\+]/and/'"
  # There are a couple of lines where tim added or deleted a file that's just
  # fern/_ (space, not underscore). I think these are causing confusion with
  # the grouping.
  commands << "sed -E '/^1354923136\\|Tim White\\|[AD]\\|\\/fern\\/ $/d'"

  sh "cat gource-log.txt | #{commands.join(' | ')} > actionsprout-history.txt"
end

task show: ['actionsprout-history.txt', 'gource.config', 'captions.txt'] do
  sh 'gource', 'actionsprout-history.txt', '--load-config', 'gource.config'
end

CLEAN << 'actionsprout-history.ppm'
rule '.ppm' => ['.txt', 'gource.config', 'captions.txt'] do |t|
  puts
  puts
  puts "*"*100
  puts "Generating video. Do not minimize the video window, it needs to render on the screen to correctly generate the video"
  puts "*"*100
  puts
  puts
  sh 'gource', t.source, '--load-config', 'gource.config', '--output-ppm-stream', t.name
end


CLOBBER << 'actionsprout-history.mp4'
rule '.mp4' => ['.ppm'] do |t|
  sh "ffmpeg -y -r 60 -f image2pipe -vcodec ppm -i #{t.source} -vcodec libx264 -preset ultrafast -pix_fmt yuv420p -crf 1 -threads 0 -bf 0 #{t.name}"
end

