# ActionSprout git history visualization

Use gource to generate a video

## Requirements

The following are required to use this tool:

* Access to the ActionSprout git organization

  enough access to clone all of the repositories listed in the Rakefile

* The following packages installed:

  * `git`
  * `ffmpeg`
  * `gource`

## Usage

To just show the video:

```
rake show
```

To generate `actionsprout-history.mp4`

```
rake generate
```

To update all git repositories (WARNING this runs `git reset --hard` in all of the git repositories in `repos`)

```
rake update
```

To clean up scratch files (except git repos)

```
rake clean
```

To remove all generated files (including git repos and mp4 file)

```
rake clobber
```
