import styled from 'styled-components';
import IssueFilter from './IssueFilter';

const Navbar = () => {
  return (
    <Nav>
      <IssueFilter />
    </Nav>
  );
};

const Nav = styled.nav`
  width: 100%;
`;

export default Navbar;
