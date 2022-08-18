alsa_output = {
  matches = {
    {
      { "node.name", "equals", "alsa_output.pci-0000_05_00.6.analog-stereo" },
    },
  },
  apply_properties = {
    ["node.name"] = "ALSA Output",
    ["node.nick"] = "Analog Output",
    ["node.description"] = "Laptop Output",
  },
}

alsa_input = {
  matches = {
    {
      { "node.name", "equals", "alsa_input.pci-0000_05_00.6.analog-stereo" },
    },
  },
  apply_properties = {
    ["node.name"] = "ALSA Input",
    ["node.nick"] = "Analog Input",
    ["node.description"] = "Laptop Input",
  },
}

behringer_output = {
  matches = {
    {
      { "node.name", "equals", "alsa_output.usb-Burr-Brown_from_TI_USB_Audio_CODEC-00.analog-stereo-input" },
    },
  },
  apply_properties = {
    ["node.name"] = "Behringer U-Phoria UM2 Output",
    ["node.nick"] = "Behringer Output",
    ["node.description"] = "Behringer Output",
  },
}

behringer_input = {
  matches = {
    {
      { "node.name", "equals", "alsa_input.usb-Burr-Brown_from_TI_USB_Audio_CODEC-00.analog-stereo-input" },
    },
  },
  apply_properties = {
    ["node.name"] = "Behringer U-Phoria UM2 Input",
    ["node.nick"] = "Behringer Input",
    ["node.description"] = "Behringer Input",
  },
}

behringer_codec = {
  matches = {
    {
      { "node.name", "equals", "alsa_output.usb-Burr-Brown_from_TI_USB_Audio_CODEC-00.analog-stereo-output" },
    },
  },
  apply_properties = {
    ["node.name"] = "Behringer U-Phoria UM2 Codec",
    ["node.nick"] = "Behringer CODEC",
    ["node.description"] = "Behringer CODEC",
  },
}
-- alsa_output.usb-Burr-Brown_from_TI_USB_Audio_CODEC-00.analog-stereo-output
table.insert(alsa_monitor.rules,alsa_output)
table.insert(alsa_monitor.rules,alsa_input)
table.insert(alsa_monitor.rules,behringer_input)
table.insert(alsa_monitor.rules,behringer_output)
table.insert(alsa_monitor.rules,behringer_codec)
