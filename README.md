./install.sh# Docker Installation Script

สคริปต์อัตโนมัติสำหรับติดตั้ง Docker และ Docker Compose บนระบบปฏิบัติการ Linux

## รายละเอียดโปรเจกต์

โปรเจกต์นี้เป็นสคริปต์ Bash ที่ช่วยในการติดตั้ง Docker CE (Community Edition) และ Docker Compose พร้อมกับปลั๊กอินที่จำเป็นบนระบบปฏิบัติการ Linux หลายตัวอย่างอัตโนมัติ สคริปต์นี้จะทำการติดตั้งและกำหนดค่าให้พร้อมใช้งานโดยไม่ต้องทำด้วยตนเอง

## ระบบปฏิบัติการที่รองรับ

สคริปต์นี้รองรับระบบปฏิบัติการ Linux ดังต่อไปนี้:

- **Ubuntu** (ทุกเวอร์ชัน)
- **Debian** (ทุกเวอร์ชัน)
- **CentOS** (เวอร์ชัน 7 ขึ้นไป)
- **Rocky Linux**
- **AlmaLinux**

## ข้อกำหนดเบื้องต้น

ก่อนการใช้งานสคริปต์ ตรวจสอบให้แน่ใจว่า:

1. **สิทธิ์ sudo**: ผู้ใช้ต้องมีสิทธิ์ sudo เพื่อติดตั้งแพ็กเกจและกำหนดค่าระบบ
2. **การเชื่อมต่ออินเทอร์เน็ต**: ต้องมีการเชื่อมต่ออินเทอร์เน็ตเพื่อดาวน์โหลดแพ็กเกจ
3. **ระบบที่รองรับ**: ระบบปฏิบัติการต้องเป็นหนึ่งในรายการที่รองรับข้างต้น

## วิธีการใช้งาน

### 1. ดาวน์โหลดสคริปต์

```bash
# ใช้ git clone
git clone https://github.com/issarapong/docker.git
cd docker

# หรือดาวน์โหลดไฟล์โดยตรง
wget https://raw.githubusercontent.com/issarapong/docker/main/install.sh
```

### 2. กำหนดสิทธิ์การเรียกใช้

```bash
chmod +x install.shchmod +x install.sh
```

### 3. เรียกใช้สคริปต์

```bash
./install.sh
```

## สิ่งที่จะได้รับการติดตั้ง

เมื่อเรียกใช้สคริปต์สำเร็จ ระบบจะได้รับการติดตั้งและกำหนดค่าดังต่อไปนี้:

### แพ็กเกจหลัก
- **Docker CE** (Community Edition) - เวอร์ชันล่าสุด
- **Docker CLI** - เครื่องมือบรรทัดคำสั่งสำหรับจัดการ Docker
- **containerd.io** - รันไทม์คอนเทนเนอร์
- **Docker Buildx Plugin** - เครื่องมือสร้าง Docker image ขั้นสูง
- **Docker Compose Plugin** - เครื่องมือจัดการคอนเทนเนอร์หลายตัว

### การกำหนดค่าระบบ
- **Docker Service**: เปิดใช้งานและเริ่มต้นบริการ Docker อัตโนมัติ
- **User Group**: เพิ่มผู้ใช้ปัจจุบันเข้ากลุ่ม `docker` เพื่อใช้งานโดยไม่ต้อง sudo

## ขั้นตอนหลังการติดตั้ง

### 1. เข้าสู่ระบบใหม่
หลังจากติดตั้งเสร็จสิ้น ให้ออกจากระบบและเข้าสู่ระบบใหม่ หรือเรียกใช้คำสั่ง:

```bash
newgrp docker
```

### 2. ทดสอบการติดตั้ง
ตรวจสอบว่า Docker ทำงานได้ปกติ:

```bash
# ตรวจสอบเวอร์ชัน Docker
docker --version

# ตรวจสอบเวอร์ชัน Docker Compose
docker compose version

# ทดสอบเรียกใช้คอนเทนเนอร์
docker run hello-world
```

### 3. ตรวจสอบสถานะบริการ
```bash
# ตรวจสอบสถานะบริการ Docker
sudo systemctl status docker

# ตรวจสอบข้อมูลระบบ Docker
docker info
```

## คำสั่งพื้นฐานสำหรับเริ่มต้น

### การจัดการคอนเทนเนอร์
```bash
# แสดงรายการคอนเทนเนอร์ที่กำลังทำงาน
docker ps

# แสดงรายการคอนเทนเนอร์ทั้งหมด
docker ps -a

# เรียกใช้คอนเทนเนอร์
docker run -d --name mycontainer nginx

# หยุดคอนเทนเนอร์
docker stop mycontainer

# ลบคอนเทนเนอร์
docker rm mycontainer
```

### การจัดการ Image
```bash
# แสดงรายการ Image
docker images

# ดาวน์โหลด Image
docker pull ubuntu:latest

# ลบ Image
docker rmi ubuntu:latest
```

## การแก้ไขปัญหาที่พบบ่อย

### 1. ปัญหาสิทธิ์การเข้าถึง
หากพบข้อผิดพลาด "permission denied" ตรวจสอบว่า:
- ผู้ใช้อยู่ในกลุ่ม docker: `groups $USER`
- หากยังไม่อยู่ในกลุ่ม: `sudo usermod -aG docker $USER`
- ออกจากระบบและเข้าใหม่

### 2. ปัญหา Repository
หากไม่สามารถเชื่อมต่อ repository ได้:
```bash
# อัปเดต package list
sudo apt update  # สำหรับ Ubuntu/Debian
sudo yum update  # สำหรับ CentOS/Rocky/AlmaLinux
```

### 3. ปัญหาบริการ Docker
หากบริการ Docker ไม่เริ่มต้น:
```bash
# เริ่มบริการ Docker
sudo systemctl start docker

# ตรวจสอบ log
sudo journalctl -u docker
```

## ข้อมูลสำคัญที่ควรทราบ

### ความปลอดภัย
- การเพิ่มผู้ใช้เข้ากลุ่ม `docker` จะให้สิทธิ์เทียบเท่า root ในการเข้าถึงระบบ
- ควรใช้ความระมัดระวังเมื่อเรียกใช้คอนเทนเนอร์จากแหล่งที่ไม่น่าเชื่อถือ

### การอัปเดต
- Docker จะได้รับการอัปเดตผ่านระบบ package manager ปกติ
- ใช้ `sudo apt upgrade` หรือ `sudo yum update` เพื่ออัปเดต

### การถอนการติดตั้ง
หากต้องการถอนการติดตั้ง Docker:
```bash
# สำหรับ Ubuntu/Debian
sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# สำหรับ CentOS/Rocky/AlmaLinux
sudo yum remove docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# ลบข้อมูลและไฟล์กำหนดค่า
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
```

## แหล่งข้อมูลเพิ่มเติม

- [เอกสาร Docker อย่างเป็นทางการ](https://docs.docker.com/)
- [คู่มือการใช้งาน Docker Compose](https://docs.docker.com/compose/)
- [Docker Hub](https://hub.docker.com/) - สำหรับค้นหา Docker Image

## การสนับสนุน

หากพบปัญหาหรือมีข้อสงสัย สามารถ:
1. ตรวจสอบ [Issues](https://github.com/issarapong/docker/issues) ใน GitHub repository
2. สร้าง Issue ใหม่หากไม่พบคำตอบ
3. ศึกษาเอกสารจากแหล่งข้อมูลเพิ่มเติมข้างต้น

---

**หมายเหตุ**: สคริปต์นี้ได้รับการทดสอบบนระบบปฏิบัติการที่รองรับ แต่ผลลัพธ์อาจแตกต่างกันขึ้นอยู่กับการกำหนดค่าของระบบแต่ละเครื่อง
