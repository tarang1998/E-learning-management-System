import React from 'react';
import {
    CDBSidebar,
    CDBSidebarContent,
    CDBSidebarFooter,
    CDBSidebarHeader,
    CDBSidebarMenu,
    CDBSidebarMenuItem,
} from 'cdbreact';
import { NavLink } from 'react-router-dom';
import { useAuth } from "../../contexts/authContext"
import { MdSpaceDashboard } from "react-icons/md";


const Sidebar = () => {

    const { getCurrentUser } = useAuth()



    return (
        <>
            {getCurrentUser() ? <div style={{ display: 'flex', height: '100vh', overflow: 'scroll initial' }}>
                <CDBSidebar textColor="#fff" backgroundColor="#333" >
                    <CDBSidebarHeader prefix={<i className="fa fa-bars fa-large"></i>}>
                        <a href="/" className="text-decoration-none" style={{ color: 'inherit' }}>
                            SkillsBerg
                        </a>
                    </CDBSidebarHeader>

                    <CDBSidebarContent className="sidebar-content">
                        <CDBSidebarMenu>

                            <NavLink exact to="/profile" activeClassName="activeClicked">
                                <CDBSidebarMenuItem icon="user">Profile</CDBSidebarMenuItem>
                            </NavLink>

                            <NavLink exact to="/dashboard" activeClassName="activeClicked">
                                <CDBSidebarMenuItem icon="columns">
                                    Dashboard
                                </CDBSidebarMenuItem>
                            </NavLink>

                            <NavLink exact to="/register-course" activeClassName="activeClicked">
                                <CDBSidebarMenuItem icon="sticky-note">Register Courses</CDBSidebarMenuItem>
                            </NavLink>


                        </CDBSidebarMenu>
                    </CDBSidebarContent>

                    {/* <CDBSidebarFooter style={{ textAlign: 'center' }}>
                        <div
                            style={{
                                padding: '20px 5px',
                            }}
                        >
                            Sidebar Footer
                        </div>
                    </CDBSidebarFooter> */}
                </CDBSidebar>
            </div> : <></>}
        </>

    );
};

export default Sidebar;