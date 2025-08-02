# 🎧 Sinusbot Docker Setup

Dieses Repository stellt ein vollständig lauffähiges **Docker-Setup für Sinusbot** zur Verfügung.  
Ziel ist es, Sinusbot sauber in Containern betreiben zu können – **inkl. persistenter Daten**, **Addons** und allem, was man für eine produktive Nutzung braucht.

---

## 🧐 Was ist Sinusbot?

[Sinusbot](https://www.sinusbot.com/) ist ein Musikbot für **Teamspeak 3** und **Discord**, der lokal oder serverseitig betrieben werden kann.  
Er streamt Musik (z. B. MP3-Dateien oder Internet-Radios), kann per Webinterface gesteuert werden, unterstützt eine Vielzahl an Scripts zur Automatisierung und lässt sich sehr granular konfigurieren.

Sinusbot eignet sich hervorragend für Gaming-Communities, Clans oder private TS3-Server, um automatisch Musik oder Soundeffekte zu spielen, Nachrichten vorlesen zu lassen (TTS) oder einfache Chat-Automationen umzusetzen.

---

## 🚀 Schnellstart

1. Repository klonen  
   ```bash
   git clone https://git.techniverse.net/scriptos/sinusbot-docker.git
   ```

2. In das Projektverzeichnis wechseln  
   ```bash
   cd sinusbot-docker
   ```

3. Schreibrechte anpassen (Benutzer-ID ggf. anpassen)  
   ```bash
   chown -R 1000:1000 data
   ```

4. (Optional) eigenes Docker-Netzwerk anlegen  
   ```bash
   docker network create --subnet=172.16.72.0/24 sinusbot.dockernetwork.local
   ```

   👉 **Hinweis:**  
   Falls du kein eigenes Netzwerk verwenden möchtest, kannst du diesen Schritt überspringen. Du musst außerdem den Abschnitt `networks:` in der `docker-compose.yaml` entsprechend entfernen oder anpassen.

5. Container starten  
   ```bash
   docker-compose up -d
   ```

6. Admin-Kennwort anzeigen lassen (wird nur nach dem ersten Start angezeigt)  
   ```bash
   docker-compose logs
   ```

👉 Im Log erscheint ein Hinweis wie:

```bash
Generating new bot instance with account 'admin' and password '3alMse7m'
PLEASE MAKE SURE TO CHANGE THE PASSWORD DIRECTLY AFTER YOUR FIRST LOGIN!!!
```

---

## 🔗 Webinterface aufrufen

Nach dem Start erreichst du das Webinterface unter:

```
http://<deine-server-ip>:8087
```

---

Die vollständige Dokumentation zur Einrichtung, zur Teamspeak-Integration, zu Scripts und Addons sowie zum Volume-Handling findest du in der [Dokumentation von Sinusbot](https://sinusbot.github.io/docs/).

---

## 🛠️ Hinweise

- Der Container läuft als Benutzer `1000:1000`. Falls dein Host-System abweicht, bitte entsprechend anpassen.

---

## 📄 Lizenz

Dieses Projekt steht unter der MIT-Lizenz.  
Die Nutzung von Sinusbot selbst unterliegt der [FAQ von sinusbot.com](https://sinusbot.github.io/docs/faq/general/).

---

Mit ❤️ von [CleverAdmin.de](https://www.cleveradmin.de)

<p align="center">
  <img src="https://assets.techniverse.net/f1/git/graphics/gray0-catonline.svg" alt="">
</p>

<p align="center">
<img src="https://assets.techniverse.net/f1/logos/small/license.png" alt="License" width="15" height="15"> <a href="./sinusbot-docker/src/branch/main/LICENSE">License</a> | <img src="https://assets.techniverse.net/f1/logos/small/matrix2.svg" alt="Matrix" width="15" height="15"> <a href="https://matrix.to/#/#community:techniverse.net">Matrix</a> | <img src="https://assets.techniverse.net/f1/logos/small/mastodon2.svg" alt="Matrix" width="15" height="15"> <a href="https://social.techniverse.net/@donnerwolke">Mastodon</a>
</p>