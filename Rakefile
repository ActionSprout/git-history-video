require 'rake/clean'
require 'digest/md5'

# Rake.application.options.trace_rules = true

repos = Rake::FileList.new(%w[
  fern
  pine
  juniper
  waterleaf
  as_jwt_auth
  crabgrass
  Snapdragon
  ivy
  huckleberry
  starflower
  pixie_eyes
  lily
  orchid
  gideon
  salmonberry
  PineDrops
  cottonwood
  dandelion
  bullseye
  willow
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

task default: :show
task generate: 'actionsprout-history.mp4'

git_repos = repos.pathmap('repos/%p.git')
multitask update: git_repos do
  git_repos.each do |repo|
    sh "(cd #{repo}; git reset --hard; git pull --ff-only)"
  end
end

CLOBBER << 'repos'
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
  project_name = t.name.pathmap('%n')
  color = Digest::MD5.hexdigest(project_name)[0..6]
  sh "cat #{t.source} | sed -E 's#(.+)\\|#\\1|/#{project_name}#' | sed -E 's/$/|#{color.upcase}/' > #{t.name}"
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
  big_message "Generating video. Do not minimize the video window, it needs to render on the screen to correctly generate the video"
  sh 'gource', t.source, '--load-config', 'gource.config', '--output-ppm-stream', t.name
end


CLOBBER << 'actionsprout-history.mp4'
rule '.mp4' => ['.ppm'] do |t|
  sh "ffmpeg -y -r 60 -f image2pipe -vcodec ppm -i #{t.source} -vcodec libx264 -preset ultrafast -pix_fmt yuv420p -crf 1 -threads 0 -bf 0 #{t.name}"
end

def big_message(message)
  puts
  puts
  puts "*" * message.length
  puts message
  puts "*" * message.length
  puts
  puts
end

