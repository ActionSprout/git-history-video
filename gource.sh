 gource \
   -1280x720 \
   --seconds-per-day 0.01 \
   --font-size 20 \
   --hide filenames,dirnames \
   --date-format '%B %Y' \
   --title "ActionSprout code changes" \
   --max-file-lag 0.1 \
   --user-image-dir .git/avatar/ \
   --user-scale 4 \
   --highlight-users \
   --camera-mode overview \
   # --file-filter '/(images\/img\/(datatables|oxygen))|vendor/' \
   test.log
   # --output-custom-log "test.log"

