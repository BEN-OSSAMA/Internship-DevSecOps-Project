import http from "k6/http";
import { sleep } from "k6";

export let options = {
  vus: 50, 
  duration: "30s",
};

export default function () {
  http.get("http://my-app.example.com/");
  sleep(1);
}
