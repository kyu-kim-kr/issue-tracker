import { Route, BrowserRouter, Switch } from 'react-router-dom';
import IssuesPage from 'pages/IssuesPage';
import LoginPage from 'pages/LoginPage';
import OAuthPage from 'pages/OAuthPage';
import NewIssuePage from 'pages/NewIssuePage';
import LabelPage from 'pages/LabelPage';
import MilestoneListPage from 'pages/MilestoneListPage';


const Router = () => {
  return (
      <>
    <BrowserRouter>
      <Switch>
        <Route path={['/', '/issues']} exact>
          <IssuesPage />
        </Route>
        <Route path={'/issues/new-issue'} exact>
          <NewIssuePage />
        </Route>
        <Route path="/login" exact>
          <LoginPage />
        </Route>
        <Route path="/login/oauth">
          <OAuthPage />
        </Route>
        <Route path="/labels" exact>
          <LabelPage />
        </Route>
        <Route path="/milestones" exact>
          <MilestoneListPage />
        </Route>
      </Switch>
    </BrowserRouter>
    </>
  );
};

export default Router;
