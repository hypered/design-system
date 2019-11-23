import React from "react";

import { Nav, NavLink, Footer } from "../../components";

function Layout(props) {
  return (
    <div className="flex flex-column justify-between min-height-vh-100 mw8 center pa4 lh-copy">
      <Nav>
        <div>
          <NavLink href="#" active={true}>
            noteed.com
          </NavLink>
          <NavLink href="#">blog</NavLink>
          <NavLink href="#">not-os</NavLink>
        </div>
      </Nav>
      {props.children}
      <Footer></Footer>
    </div>
  );
}

export { Layout };
