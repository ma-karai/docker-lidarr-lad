#!/usr/bin/with-contenv bash

echo "Updating LAD scripts..."


# Remove lock file incase, system was rebooted before script finished
if [ -d /config/scripts/00-lidarr-automated-downloader.exclusivelock ]; then
	rmdir /config/scripts/00-lidarr-automated-downloader.exclusivelock
fi

# Delete existing config file to update from settings

if [ -f "/config/scripts/lidarr-automated-downloader/config" ]; then
	rm "/config/scripts/lidarr-automated-downloader/config"
	sleep 0.1
fi

# Create config file

if [ -z "$downloadmethod" ]; then
	downloadmethod="album"
fi
if [ -z "$enablefallback" ]; then
	enablefallback="true"
fi
if [ -z "$VerifyTrackCount" ]; then
	VerifyTrackCount="true"
fi
if [ -z "$dlcheck" ]; then
	dlcheck=3
fi
if [ -z "$albumtimeoutpercentage" ]; then
	albumtimeoutpercentage=8
fi
if [ -z "$tracktimeoutpercentage" ]; then
	tracktimeoutpercentage=25
fi
if [ -z "$ReplaygainTagging" ]; then
	ReplaygainTagging="FALSE"
fi
if [ -z "$FilePermissions" ]; then
	FilePermissions="666"
fi
if [ -z "$FolderPermissions" ]; then
	FolderPermissions="777"
fi
if [ -z "$amount" ]; then
	amount="1000000000"
fi
if [ -z "$quality" ]; then
	quality="FLAC"
fi
if [ -z "$ConversionBitrate" ]; then
	ConversionBitrate="320"
fi
if [ -z "$deezloaderurl" ]; then
	deezloaderurl="http://127.0.0.1:1730"
fi
if [ -z "$LidarrUrl" ]; then
	LidarrUrl="http://127.0.0.1:8686"
fi
if [ -z "$LidarrImportLocation" ]; then
	LidarrImportLocation="/downloads/lidarr-import"
fi
if [ -z "$downloaddir" ]; then
	downloaddir="/downloads/deezloaderremix"
fi
if [ -z "$DownLoadArtistArtwork" ]; then
	DownLoadArtistArtwork="false"
fi

touch "/config/scripts/lidarr-automated-downloader/config"
echo 'LidarrApiKey="$(grep "<ApiKey>" /config/config.xml | sed "s/\  <ApiKey>//;s/<\/ApiKey>//")"' >> "/config/scripts/lidarr-automated-downloader/config"
echo "downloadmethod=\"$downloadmethod\"" >> "/config/scripts/lidarr-automated-downloader/config"
echo "enablefallback=\"$enablefallback\"" >> "/config/scripts/lidarr-automated-downloader/config"
echo "VerifyTrackCount=\"$VerifyTrackCount\"" >> "/config/scripts/lidarr-automated-downloader/config"
echo "dlcheck=$dlcheck" >> "/config/scripts/lidarr-automated-downloader/config"
echo "albumtimeoutpercentage=$albumtimeoutpercentage" >> "/config/scripts/lidarr-automated-downloader/config"
echo "tracktimeoutpercentage=$tracktimeoutpercentage" >> "/config/scripts/lidarr-automated-downloader/config"
echo "ReplaygainTagging=\"$ReplaygainTagging\"" >> "/config/scripts/lidarr-automated-downloader/config"
echo "FilePermissions=\"$FilePermissions\"" >> "/config/scripts/lidarr-automated-downloader/config"
echo "FolderPermissions=\"$FolderPermissions\"" >> "/config/scripts/lidarr-automated-downloader/config"
echo "amount=\"$amount\"" >> "/config/scripts/lidarr-automated-downloader/config"
echo "quality=\"$quality\"" >> "/config/scripts/lidarr-automated-downloader/config"
echo "ConversionBitrate=\"$ConversionBitrate\"" >> "/config/scripts/lidarr-automated-downloader/config"
echo "deezloaderurl=\"$deezloaderurl\"" >> "/config/scripts/lidarr-automated-downloader/config"
echo "LidarrUrl=\"$LidarrUrl\"" >> "/config/scripts/lidarr-automated-downloader/config"
echo "LidarrImportLocation=\"$LidarrImportLocation\"" >> "/config/scripts/lidarr-automated-downloader/config"
echo "downloaddir=\"$downloaddir\"" >> "/config/scripts/lidarr-automated-downloader/config"
echo "DownLoadArtistArtwork=\"$DownLoadArtistArtwork\"" >> "/config/scripts/lidarr-automated-downloader/config"

# Set permissions
find /config/scripts -type f -exec chmod 0666 {} \;
find /config/scripts -type d -exec chmod 0777 {} \;

echo "Complete..."
exit 0
