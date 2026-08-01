import { installHeadroomTransport } from "../dist/chunk-KWQK2FAO.js";

const proxyUrl = process.env.HEADROOM_OPENCODE_TRANSPORT_PROXY_URL;
if (proxyUrl) {
  installHeadroomTransport({ proxyUrl });
}
