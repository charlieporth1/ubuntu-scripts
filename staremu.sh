# setup and launch emulator inside the container
# create a new Android Virtual Device
echo "no" | avdmanager create avd -n test -k "system-images;android-25;google_apis;armeabi-v7a"
# launch emulator
emulator -avd test -no-audio -no-boot-anim -accel on -gpu swiftshader_indirect &
