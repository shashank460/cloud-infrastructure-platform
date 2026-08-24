import express from "express";

const app = express();
app.use(express.json());

app.get("/health", (_req, res) => res.json({ status: "healthy" }));
app.get("/ready", (_req, res) => res.json({ status: "ready" }));
app.get("/", (_req, res) =>
  res.json({ service: "cloud-platform-demo-api", version: "1.0.0" })
);

export { app };

const port = Number(process.env.PORT || 3000);

if (process.env.NODE_ENV !== "test") {
  app.listen(port, "0.0.0.0", () =>
    console.log(`API listening on ${port}`)
  );
}
