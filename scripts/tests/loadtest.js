import http from "k6/http";
import { sleep } from "k6";

export let options = {
  vus: 50,         // 50 utilisateurs virtuels
  duration: "30s", // durée du test
  thresholds: {
    http_req_failed: ["rate<0.01"],       // taux d'erreur < 1%
    http_req_duration: ["p(95)<200"],     // 95% des requêtes < 200ms
  },
};

export default function () {
  // URL de ton application Docker
  http.get("http://localhost:4220/"); // remplacer par ton endpoint réel
  sleep(1);  // pause 1 seconde entre chaque requête
}
