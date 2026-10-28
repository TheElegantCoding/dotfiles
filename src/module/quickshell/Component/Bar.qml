import QtQuick
import Quickshell
import "../Style" as Style

PanelWindow {
  id: barWindow
  implicitHeight: 36
  color: "transparent"

  anchors {
    top: true
    left: true
    right: true
  }

  margins {
    top: 8
    left: 8
    right: 8
  }

  Rectangle {
    height: 36
    radius: 36
    width: contentRow.width + 40
    color: Style.Color.background950


    Row {
      id: contentRow
      anchors.verticalCenter: parent.verticalCenter
      anchors.left: parent.left
      anchors.leftMargin: 20
      spacing: 12

      Image {
        width: 16
        height: 16
        source: Qt.resolvedUrl("../Asset/bsd.svg")
        sourceSize.width: 16
        sourceSize.height: 16
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: parent.verticalCenter
      }

      Repeater {
        model: 10
        Rectangle {
          implicitWidth: 12
          implicitHeight: 12
          radius: 16
          color: Style.Color.background900
          anchors.verticalCenter: parent.verticalCenter
        }
      }
    }
  }
}