# mp4merge

## Merge MP4 as chapters

This container runs a script to merge all MP4 files in /src to /target/output.mp4 . A YouTube description friendly log file "output.log" is also generated.

Merge MP4 files with script from https://gist.github.com/decatoncheir/5540ba76879ee0179be27278fd51aff8

With comment from yermak, I got a version of mp4v2 that works with the script. https://github.com/donmelton/video_transcoding/issues/306#issuecomment-730371312

Please refer to docker-compose.yml for sample docker-compose configurations.

The image avaliable on https://hub.docker.com/r/decatoncheir/mp4merge and ghcr.io/decatoncheir/mp4merge:latest
