# Pacific to the Plata

A single-file, poster-style SVG map of a South America overland route: from Valparaiso and Santiago across the Andes by bus, north through Mendoza, Cafayate, Salta, and the Quebrada de Humahuaca, then south-east via Cordoba to Buenos Aires and Montevideo on the Rio de la Plata.

Everything lives in `index.html` (inline CSS and SVG, no dependencies). It is responsive, keyboard-focusable, and has a print stylesheet.

## View

Open `index.html` in any modern browser.

## Scripts (Windows PowerShell)

```powershell
# Check that the poster contains every stop, label, and accessibility hook
powershell -ExecutionPolicy Bypass -File tests/verify-map.ps1

# Export a 1524x980 PNG using headless Microsoft Edge
powershell -ExecutionPolicy Bypass -File scripts/export-poster.ps1
```

The route is stylized for display, not drawn to geographic scale.
