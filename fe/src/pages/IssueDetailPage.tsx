import { Divider } from '@material-ui/core';
import Header from 'components/header/Header';
import IssueDetailBody from 'components/issue-detail/IssueDetailBody';
import IssueDetailHeader from 'components/issue-detail/IssueDetailHeader';
import styled from 'styled-components';

const IssueDetailPage = () => (
  <>
    <Header />
    <IssueDetailHeader />
    <Divider />
    <IssueDetailBody></IssueDetailBody>
  </>
);

export default IssueDetailPage;
