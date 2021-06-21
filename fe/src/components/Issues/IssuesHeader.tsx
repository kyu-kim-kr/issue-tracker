import styled from 'styled-components';
import { Button, Checkbox } from '@material-ui/core';
import { ReactComponent as Open } from 'icons/openIssue.svg';
import { ReactComponent as Close } from 'icons/closeIssue.svg';
import Filter from 'components/common/Filter';
import { useSetRecoilState } from 'recoil';
import { issuesStateAtom } from 'store';
import { MouseEvent } from 'react';

const IssuesHeader = () => {
  const setIssuesState = useSetRecoilState(issuesStateAtom);
  const clickOpenHandler = (e: MouseEvent) => {
    setIssuesState(false);
  };
  const clickCloseHandler = (e: MouseEvent) => {
    setIssuesState(true);
  };
  return (
    <StyledIssuesHeader>
      <IssuesHeaderLeft>
        <Checkbox color="primary" />
        <IssuesButton onClick={clickOpenHandler}>
          <OpenSvg /> 열린 이슈(2)
        </IssuesButton>
        <IssuesButton onClick={clickCloseHandler}>
          <CloseSvg />
          닫힌 이슈(0)
        </IssuesButton>
      </IssuesHeaderLeft>
      <IssuesHeaderRight>
        <Filter filterType="milestoneList" />
        <Filter filterType="labelList" />
        <Filter filterType="labelList" />
        <Filter filterType="labelList" />
      </IssuesHeaderRight>
    </StyledIssuesHeader>
  );
};

export default IssuesHeader;

const IssuesButton = styled(Button)`
  color: ${({ theme }) => theme.color.grayscale.titleActive};
  stroke: ${({ theme }) => theme.color.grayscale.titleActive};
  font-weight: 700;
`;

const StyledIssuesHeader = styled.div`
  ${({ theme }) => theme.style.flexSpaceBetween}
  box-sizing: border-box;

  padding: 1rem;
`;

const OpenSvg = styled(Open)`
  path {
    stroke: inherit;
  }
  margin-right: 0.2rem;
`;
const CloseSvg = styled(Close)`
  path {
    stroke: inherit;
  }
  margin-right: 0.2rem;
`;

const IssuesHeaderLeft = styled.div``;
const IssuesHeaderRight = styled.div``;
