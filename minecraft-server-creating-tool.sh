#!/bin/bash
# Check if ran with sudo permissions


apt install -y -q screen
echo "Screen is installed."
apt install -y -q openjdk-16-jdk-headless
echo "Java (16) is installed."
mkdir -p "$LOCATION"
mkdir "plugins"
wget "https://ci.opencollab.dev//job/GeyserMC/job/Geyser/job/master/lastSuccessfulBuild/artifact/bootstrap/spigot/target/Geyser-Spigot.jar" -P "$LOCATION"/plugins

echo "Creating server..."

# Download server.jar
curl -s https://minecraft-mirror.io/spigot-1.16.5.jar -o "$LOCATION"/server.jar

# Create start.sh
cat > "$LOCATION"/start.sh << EOF
#!/bin/bash
screen -S $NAME java -Xms128M -Xmx1G -jar server.jar nogui
EOF
echo 'eula=true' > "$LOCATION"/eula.txt

# Chmod the start.sh file
chmod +x "$LOCATION"/start.sh

echo -e "Your server is created! Use 'cd $LOCATION && ./start.sh' to start the server"
