const puppeteer = require("puppeteer");
const fs = require("fs");

const renderMermaidToSVG = async (mermaidCode) => {
  const browser = await puppeteer.launch({ headless: "new" });
  const page = await browser.newPage();

  await page.setContent(`
    <html>
      <body>
        <div class="mermaid">${mermaidCode}</div>
        <script src="https://unpkg.com/mermaid/dist/mermaid.min.js"></script>
        <script>mermaid.init(undefined, document.querySelectorAll('.mermaid'));</script>
      </body>
    </html>
  `);

  await page.waitForSelector(".mermaid svg");

  const svgElement = await page.$(".mermaid svg");
  const svg = await svgElement.evaluate((node) => node.outerHTML);

  await browser.close();
  return svg;
};

const main = async () => {
  const mermaidCode = `
    graph TD;
    A-->B;
    B-->C;
  `;

  const svgOutput = await renderMermaidToSVG(mermaidCode);

  // Save SVG to a local file
  fs.writeFileSync("output.svg", svgOutput);
};

main();
