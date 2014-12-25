  APNS.host = 'gateway.sandbox.push.apple.com'
  APNS.pem = File.join(Rails.root, "CombinedCertKey.pem")
  APNS.port = 2195
  APNS.pass = "AAPLintheTree23"

  device_token = "ba1d3340473f244737a56456bc72b9cc8ae027328e26fa158ce5e6b8f7ef26bf"
  # APNS.send_notification(device_token, "Fuck you bro")

