import QtQuick 6.5
import QtQuick.Controls 6.5
import QtMultimedia 6.5
import SddmComponents 2.0

Rectangle {
  id: root
  width: 1920
  height: 1080
  color: "#050508"

  // ==========================================
  // 1. MULTIMEDIA: VIDEO DE FONDO
  // ==========================================
  MediaPlayer {
    id: bgPlayer
    source: "asset/background.mp4"
    autoPlay: true
    loops: MediaPlayer.Infinite
    volume: 0.0
  }

  Shortcut {
    sequence: "Escape"
    onActivated: Qt.quit()
  }

  VideoOutput {
    anchors.fill: parent
    source: bgPlayer
  }

  Rectangle {
    anchors.fill: parent
    color: "#000000"
    opacity: 0.4
  }

  // ==========================================
  // 2. INTERFAZ DE USUARIO (UI CYBERPUNK)
  // ==========================================
  Column {
    anchors.centerIn: parent
    spacing: 24

    // Título de Estado
    Text {
      anchors.horizontalCenter: parent.horizontalCenter
      text: "SYSTEM_ACCESS // " + (userModel.lastUser ? userModel.lastUser.toUpperCase() : "ROOT")
      color: "#00f5ff"
      font.pixelSize: 20
      font.bold: true
      font.family: "JetBrains Mono"
    }

    // Campo de Contraseña
    TextField {
      id: passwordInput
      width: 320
      height: 52
      echoMode: TextInput.Password
      placeholderText: "ENTER CREDENTIALS..."
      placeholderTextColor: "#00f5ff"
      color: "#ffffff"
      font.pixelSize: 15
      font.family: "JetBrains Mono"
      focus: true

      // Estilo visual del input (Bordes neón dinámicos estilo CSS)
      background: Rectangle {
        color: "#e60a0a12"
        border.color: passwordInput.activeFocus ? "#00f5ff" : "#ff007f"
        border.width: 2
        radius: 6
      }

      // Ejecutar login al presionar ENTER
      onAccepted: {
        sddm.login(userModel.lastUser, passwordInput.text, sessionModel.lastIndex)
      }
    }
  }

  // ==========================================
  // 3. CONEXIÓN CON LOS EVENTOS DE SDDM
  // ==========================================
  Connections {
    target: sddm
    function onLoginSucceeded() {
    }
    function onLoginFailed() {
      passwordInput.text = ""
    }
  }
}