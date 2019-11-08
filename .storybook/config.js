import { configure, addDecorator } from "@storybook/react";
import { withStaticMarkup } from "storybook-react-to-static-markup";
import "../static/css/styles.css";
import "../static/css/tachyons.css";

// automatically import all files ending in *.stories.js
configure(
  [
    require.context("../stories", true, /\.stories\.js$/),
    require.context("../components", true, /\.stories\.js$/),
  ],
  module,
);

addDecorator(withStaticMarkup);

addDecorator(storyFn => (
  <div className="inter" style={{ padding: "0" }}>
    {storyFn()}
  </div>
));
