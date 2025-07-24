IMG_PATH=~/codebase/compiler/gem5-vega/test/gem5-resources/src/x86-ubuntu-gpu-ml

~/codebase/compiler/qemu/build_x86/install/bin/qemu-system-x86_64 \
    -enable-kvm \
    -cpu host \
    -smp 16 \
    -m 32768 \
    -machine q35,accel=kvm \
    -nographic \
    -kernel ${IMG_PATH}/vmlinux-gpu-ml \
    -drive file=${IMG_PATH}/disk-image/x86-ubuntu-gpu-ml,format=raw,if=virtio \
    -append "root=/dev/vda1 rw console=ttyS0,115200 earlyprintk=ttyS0 net.ifnames=0" \
    -device virtio-net-pci,netdev=net0 \
    -netdev user,id=net0,hostfwd=tcp::3456-:22 \
    -fsdev local,security_model=passthrough,id=fsdev-fs0,path=/home/zhaosiying/codebase/compiler/gem5-vega/gem5/shared \
    -device virtio-9p-pci,id=fs0,fsdev=fsdev-fs0,mount_tag=gem5,bus=pcie.0,addr=0xf
