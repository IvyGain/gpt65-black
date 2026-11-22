#include <Arduino.h>
#include <Wire.h>

#if !defined(ARDUINO_Seeed_XIAO_nRF52840)
#error Select Seeed XIAO nRF52840 (non-Sense, non-Plus).
#endif

static_assert(PIN_WIRE_SDA == 4 && PIN_WIRE_SCL == 5, "Check the board's I2C pins");

constexpr uint8_t kAddress = 0x74;
constexpr uint8_t kReadyPin = D0;
constexpr uint16_t kExpectedProduct = 40;
constexpr unsigned long kReadyTimeoutMs = 1000;

void probe() {
  const unsigned long started = millis();
  while (digitalRead(kReadyPin) != LOW) {
    if (millis() - started >= kReadyTimeoutMs) {
      Serial.println("FAIL RDY timeout (no I2C attempted)");
      return;
    }
    yield();
  }

  Wire.beginTransmission(kAddress);
  Wire.write(uint8_t{0x00});
  Wire.write(uint8_t{0x00});
  const uint8_t addressStatus = Wire.endTransmission(false);
  if (addressStatus != 0) {
    Serial.print("FAIL register address status=");
    Serial.println(addressStatus);
    return;
  }

  const uint8_t count = Wire.requestFrom(kAddress, size_t{2}, true);
  const int high = Wire.read();
  const int low = Wire.read();

  // Close the communication window with the protocol command.
  Wire.beginTransmission(kAddress);
  Wire.write(uint8_t{0xEE});
  Wire.write(uint8_t{0xEE});
  Wire.write(uint8_t{0x01});
  const uint8_t closeStatus = Wire.endTransmission(true);

  if (count != 2 || high < 0 || low < 0) {
    Serial.print("FAIL product read length=");
    Serial.println(count);
  } else {
    const uint16_t product = (uint16_t(high) << 8) | uint16_t(low);
    Serial.print(product == kExpectedProduct && closeStatus == 0
                     ? "PASS product=" : "FAIL product=");
    Serial.println(product);
  }
  Serial.print("End communication status=");
  Serial.println(closeStatus);
}

void setup() {
  Serial.begin(115200);
  pinMode(kReadyPin, INPUT);
  Wire.begin();
  Wire.setClock(100000);
}

void loop() {
  if (Serial.available() && Serial.read() == 'p') {
    probe();
  }
}
