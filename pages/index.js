// This is the index page of the main site, visible at
// https://hypered.github.io/design-system/.
import React from "react";

import {
  HomeLayout,
  HeaderSection,
  GettingStartedSection,
  GalleryPreviewSection,
} from "../components";

function Home() {
  return (
    <HomeLayout>
      <HeaderSection />

      <GettingStartedSection />

      <GalleryPreviewSection />
    </HomeLayout>
  );
}

export default Home;
