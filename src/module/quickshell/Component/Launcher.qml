import QtQuick
import Quickshell
import Quickshell.Wayland
import QtQuick.Effects
import "../Style" as Style

PanelWindow {
  id: mainWindow
  implicitWidth: 800
  implicitHeight: 600
  color: "transparent"

  Item {
    anchors.fill: parent
    anchors.margins: 30

    RectangularShadow {
      anchors.fill: parent
      radius: 12
      blur: 50
      spread: -12
      offset.y: 20
      opacity: 0.25
      color: Style.Color.primary600
    }

    Rectangle {
      anchors.fill: parent
      radius: 12

      gradient: Gradient {
        GradientStop { position: 0.0; color: Style.Color.primary600 }
        GradientStop { position: 1.0; color: Style.Color.secondary600 }
      }

      Rectangle {
        color: Style.Color.background950
        anchors.fill: parent
        anchors.margins: 2
        radius: 11

        Text {
          anchors.centerIn: parent
          text: "¡Ahora sí se ve la sombra/brillo!"
          color: "#cdd6f4"
          font.pixelSize: 18
        }
      }
    }
  }
}